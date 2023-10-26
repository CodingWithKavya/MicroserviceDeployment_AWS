# -*- coding: utf-8 -*-
"""
Created on Wed Oct 25 21:37:45 2023

@author: kavya
"""
#Working Program
import multiprocessing
import time

def stress_task():
    while True:
        # This is a CPU-bound task
        total = 0
        for j in range(1000000):
            total += j

if __name__ == "__main__":
    process_num = 9  # Change process number accordingly

    process_list = []

    for _ in range(process_num):
        ps = multiprocessing.Process(target=stress_task)
        ps.start()
        process_list.append(ps)

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("CPU overload script is stopped now")
        for p in process_list:
            p.terminate()
