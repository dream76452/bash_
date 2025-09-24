#!/bin/bash

file="processing.log"

max_duration=0
longest_video=""

for video in $(grep "Начал обработку" "$file" | awk '{print $6}' | sort -u); do
    # Находим время начала
    start_time=$(grep "Начал обработку $video" "$file" | awk '{print $1,$2}')
    
    # Находим время окончания
    end_time=$(grep "Завершено: $video" "$file" | awk '{print $1,$2}')
    
    # Проверяем, что оба времени найдены
    if [ -z "$start_time" ] || [ -z "$end_time" ]; then
        continue
    fi
    
    # Преобразуем в секунды
    start=$(date -d "$start_time" +%s)
    end=$(date -d "$end_time" +%s)
    
    # Длительность
    duration=$((end - start))
    
    # Сравниваем
    if [ $duration -gt $max_duration ]; then
        max_duration=$duration
        longest_video=$video
    fi
done

# Выводим результат
if [ -n "$longest_video" ]; then
    echo "$longest_video $max_duration"
else
    echo "Видео не найдено или не обработано"
fi
