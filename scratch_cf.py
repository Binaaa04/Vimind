import json
answers_json = """[
    {"symptom_id": 88, "value": 0}, {"symptom_id": 89, "value": 0}, {"symptom_id": 90, "value": 0.4},
    {"symptom_id": 91, "value": 0.4}, {"symptom_id": 92, "value": 0.4}, {"symptom_id": 93, "value": 1},
    {"symptom_id": 94, "value": 0.7}, {"symptom_id": 95, "value": 0.7}, {"symptom_id": 96, "value": 0},
    {"symptom_id": 97, "value": 1}, {"symptom_id": 99, "value": 0.4}, {"symptom_id": 100, "value": 0.7},
    {"symptom_id": 101, "value": 0}, {"symptom_id": 102, "value": 0}, {"symptom_id": 104, "value": 0.7},
    {"symptom_id": 107, "value": 1}, {"symptom_id": 108, "value": 0.4}, {"symptom_id": 109, "value": 0.7},
    {"symptom_id": 110, "value": 0}, {"symptom_id": 111, "value": 1}, {"symptom_id": 112, "value": 0},
    {"symptom_id": 113, "value": 0.7}, {"symptom_id": 114, "value": 0.4}, {"symptom_id": 116, "value": 1},
    {"symptom_id": 117, "value": 0.7}, {"symptom_id": 118, "value": 1}, {"symptom_id": 127, "value": 0},
    {"symptom_id": 128, "value": 1}, {"symptom_id": 129, "value": 0.7}, {"symptom_id": 130, "value": 0},
    {"symptom_id": 131, "value": 1}, {"symptom_id": 132, "value": 0}, {"symptom_id": 133, "value": 1},
    {"symptom_id": 134, "value": 0.7}, {"symptom_id": 105, "value": 0}, {"symptom_id": 106, "value": 0.7},
    {"symptom_id": 107, "value": 1}, {"symptom_id": 109, "value": 0.7}, {"symptom_id": 158, "value": 0},
    {"symptom_id": 141, "value": 1}, {"symptom_id": 142, "value": 0.4}, {"symptom_id": 143, "value": 0.7},
    {"symptom_id": 144, "value": 0}, {"symptom_id": 145, "value": 0.4}, {"symptom_id": 146, "value": 1},
    {"symptom_id": 147, "value": 0.7}, {"symptom_id": 148, "value": 1}, {"symptom_id": 149, "value": 0},
    {"symptom_id": 150, "value": 0.7}, {"symptom_id": 151, "value": 0.4}, {"symptom_id": 152, "value": 1},
    {"symptom_id": 153, "value": 0.7}, {"symptom_id": 154, "value": 1}, {"symptom_id": 168, "value": 0},
    {"symptom_id": 170, "value": 0.4}, {"symptom_id": 171, "value": 0.7}, {"symptom_id": 172, "value": 0.4}
]"""

rules_csv = """1,1,88,0.9
2,1,89,0.9
3,1,90,0.8
4,1,91,0.75
5,1,92,0.85
6,1,93,0.85
7,1,94,0.75
8,1,95,0.75
9,1,96,0.8
10,2,97,0.85
11,2,99,0.8
12,2,100,0.75
13,2,101,0.75
14,2,102,0.7
15,2,104,0.8
18,3,107,0.8
19,3,108,0.75
20,3,109,0.75
21,3,110,0.7
22,3,111,0.75
23,4,112,0.9
24,4,113,0.85
25,4,114,0.8
26,4,116,0.8
27,4,117,0.75
28,4,118,0.7
29,5,127,0.9
30,5,128,0.85
31,5,129,0.8
32,5,130,0.8
33,5,131,0.75
34,5,132,0.8
35,5,133,0.85
36,5,134,0.8
42,7,141,0.9
43,7,142,0.85
44,7,143,0.85
45,7,144,0.75
46,7,145,0.7
47,7,146,0.7
48,7,147,0.75
49,7,148,0.75
50,8,149,0.75
51,8,150,0.7
52,8,151,0.7
53,8,152,0.75
54,8,153,0.7
55,8,154,0.7
56,9,168,0.9
57,9,170,0.85
58,9,171,0.9
59,9,172,0.75
74,6,105,0.9
75,6,106,0.9
76,6,107,0.85
77,6,109,0.7
78,6,158,0.8"""

answers = json.loads(answers_json)
ans_dict = {a["symptom_id"]: a["value"] for a in answers}

disease_cf = {}
for line in rules_csv.split('\n'):
    if not line.strip(): continue
    parts = line.split(',')
    disease_id = int(parts[1])
    symptom_id = int(parts[2])
    expert_cf = float(parts[3])
    
    if disease_id not in disease_cf:
        disease_cf[disease_id] = 0.0
        
    user_val = ans_dict.get(symptom_id, 0.0)
    cf_entry = user_val * expert_cf
    current_cf = disease_cf[disease_id]
    disease_cf[disease_id] = current_cf + cf_entry * (1 - current_cf)

for d, cf in sorted(disease_cf.items(), key=lambda x: x[1], reverse=True):
    print(f"Penyakit ID {d}: {cf*100:.2f}%")
