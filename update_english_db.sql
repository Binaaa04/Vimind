BEGIN;

-- 1. Update diseases to English terminology
UPDATE disease SET disease_name = 'Anxiety', description = 'A mental health disorder characterized by feelings of worry, anxiety, or fear that are strong enough to interfere with one''s daily activities.' WHERE disease_id = 1;
UPDATE disease SET disease_name = 'PTSD', description = 'Post-Traumatic Stress Disorder: A psychiatric disorder that may occur in people who have experienced or witnessed a traumatic event.' WHERE disease_id = 2;
UPDATE disease SET disease_name = 'Depression', description = 'A mood disorder that causes a persistent feeling of sadness and loss of interest.' WHERE disease_id = 3;
UPDATE disease SET disease_name = 'OCD', description = 'Obsessive-Compulsive Disorder: A mental illness that causes repeated unwanted thoughts or sensations (obsessions) or the urge to do something over and over again (compulsions).' WHERE disease_id = 4;
UPDATE disease SET disease_name = 'Bipolar', description = 'Bipolar Disorder: A mental health condition that causes extreme mood swings that include emotional highs (mania or hypomania) and lows (depression).' WHERE disease_id = 5;
UPDATE disease SET disease_name = 'Schizophrenia', description = 'A serious mental disorder in which people interpret reality abnormally, leading to some combination of hallucinations, delusions, and extremely disordered thinking and behavior.' WHERE disease_id = 6;
UPDATE disease SET disease_name = 'Social Anxiety', description = 'Social Anxiety Disorder: A chronic mental health condition in which social interactions cause irrational anxiety, fear, self-consciousness, and embarrassment.' WHERE disease_id = 7;
UPDATE disease SET disease_name = 'Panic Disorder', description = 'An anxiety disorder characterized by reoccurring unexpected panic attacks.' WHERE disease_id = 8;
UPDATE disease SET disease_name = 'ADHD', description = 'Attention-Deficit/Hyperactivity Disorder: A chronic condition including attention difficulty, hyperactivity, and impulsiveness.' WHERE disease_id = 9;
UPDATE disease SET disease_name = 'Mentally Stable (Healthy)', description = 'Mentally stable state without any significant indication of psychological disorder.' WHERE disease_id = 10;

-- 2. Clear old cf_rules
DELETE FROM cf_rules WHERE disease_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9);

-- 3. Clear existing symptoms (to prevent bloat, deleting the ones we created earlier)
DELETE FROM symptoms WHERE symptoms_code LIKE 'G-ANX%' OR symptoms_code LIKE 'G-PTSD%' OR symptoms_code LIKE 'G-DEP%' OR symptoms_code LIKE 'G-BIP%' OR symptoms_code LIKE 'G-FOB%' OR symptoms_code LIKE 'G-OCD%' OR symptoms_code LIKE 'G-SKZ%' OR symptoms_code LIKE 'G-PNK%' OR symptoms_code LIKE 'G-AHD%';

-- 4. Insert New English Symptoms
WITH new_symptoms AS (
    INSERT INTO symptoms (symptoms_code, symptoms_name, description) VALUES
    ('G-DEP1', 'Profound sadness', 'Feeling extremely sad, empty, or hopeless most of the day.'),
    ('G-DEP2', 'Loss of interest (Anhedonia)', 'Loss of interest or pleasure in almost all activities.'),
    ('G-DEP3', 'Feelings of worthlessness', 'Frequent feelings of excessive guilt, worthlessness, or self-blame.'),
    ('G-DEP4', 'Extreme fatigue', 'Feeling extremely tired and lacking energy for daily tasks.'),
    ('G-DEP5', 'Changes in appetite', 'Significant increase or decrease in appetite and weight.'),

    ('G-ANX1', 'Excessive worry', 'Frequent and hard-to-control worry about various things.'),
    ('G-ANX2', 'Restlessness', 'Feeling keyed up, restless, or on edge.'),
    ('G-ANX3', 'Difficulty concentrating', 'Mind going blank or having trouble focusing on tasks.'),
    ('G-ANX4', 'Muscle tension', 'Experiencing frequent muscle tension in the shoulders, neck, or other body parts.'),
    ('G-ANX5', 'Sleep disturbances', 'Difficulty falling asleep or staying asleep due to racing thoughts.'),

    ('G-PTSD1', 'Flashbacks', 'Frequently reliving a traumatic event as if it were happening again.'),
    ('G-PTSD2', 'Trauma-related nightmares', 'Experiencing distressing dreams related to past trauma.'),
    ('G-PTSD3', 'Avoidance of triggers', 'Going out of the way to avoid places, people, or activities that remind you of the trauma.'),
    ('G-PTSD4', 'Hyperarousal', 'Feeling constantly on guard or being easily startled.'),
    ('G-PTSD5', 'Emotional numbness', 'Feeling empty, detached from others, or unable to experience positive emotions.'),

    ('G-BIP1', 'Drastic mood swings', 'Experiencing rapid shifts from feeling extremely happy to very sad.'),
    ('G-BIP2', 'Explosive energy (Mania)', 'Having excessive energy, talking unusually fast, and having racing thoughts.'),
    ('G-BIP3', 'Decreased need for sleep', 'Feeling fully rested despite getting only a few hours of sleep.'),
    ('G-BIP4', 'Impulsive behavior', 'Frequently making high-risk decisions without considering consequences.'),
    ('G-BIP5', 'Severe depressive episodes', 'Experiencing deep sadness following periods of elevated energy.'),

    ('G-FOB1', 'Fear of being judged', 'Overwhelming fear of being observed or judged negatively by others.'),
    ('G-FOB2', 'Avoiding social interactions', 'Intentionally avoiding social gatherings or speaking with strangers.'),
    ('G-FOB3', 'Anxiety before social events', 'Experiencing severe anxiety days before attending a social event.'),
    ('G-FOB4', 'Physical symptoms during interaction', 'Heart palpitations, sweating, or trembling when interacting with people.'),
    ('G-FOB5', 'Difficulty maintaining eye contact', 'Finding it extremely difficult to look people in the eyes while speaking.'),

    ('G-OCD1', 'Recurrent obsessive thoughts', 'Having repeated, unwanted thoughts, urges, or mental images.'),
    ('G-OCD2', 'Repetitive compulsive behaviors', 'Feeling driven to perform certain actions over and over again.'),
    ('G-OCD3', 'Fear of contamination', 'Excessive fear of dirt, germs, or disease.'),
    ('G-OCD4', 'Excessive need for order', 'A strong need for things to be symmetrical or in perfect order.'),
    ('G-OCD5', 'Severe anxiety if routine disrupts', 'Experiencing severe anxiety when routines are interrupted.'),

    ('G-SKZ1', 'Hallucinations', 'Hearing voices or seeing things that are not actually there.'),
    ('G-SKZ2', 'Delusions', 'Holding strong, irrational beliefs that do not match reality.'),
    ('G-SKZ3', 'Disorganized thinking', 'Speaking in a confusing manner or frequently jumping between unrelated topics.'),
    ('G-SKZ4', 'Lack of emotional expression', 'Having a flat affect, poor eye contact, or failing to respond emotionally.'),
    ('G-SKZ5', 'Severe social withdrawal', 'Losing interest in daily activities and completely isolating oneself.'),

    ('G-PNK1', 'Sudden panic attacks', 'Experiencing intense, sudden episodes of fear without clear reason.'),
    ('G-PNK2', 'Rapid heartbeat', 'Feeling your heart beating very fast, pounding, or irregularly.'),
    ('G-PNK3', 'Shortness of breath', 'Having difficulty breathing, chest tightness, or feeling smothered.'),
    ('G-PNK4', 'Excessive sweating and trembling', 'Breaking into cold sweats, trembling, or shaking excessively.'),
    ('G-PNK5', 'Fear of losing control or dying', 'Feeling like you are going crazy, losing control, or about to die.'),

    ('G-AHD1', 'Difficulty sustaining attention', 'Frequently struggling to maintain focus on tasks or play activities.'),
    ('G-AHD2', 'Easily distracted', 'Being easily side-tracked by external, irrelevant stimuli.'),
    ('G-AHD3', 'Restlessness and inability to sit still', 'Often fidgeting or finding it impossible to stay seated.'),
    ('G-AHD4', 'Impulsive behavior', 'Acting without thinking, interrupting conversations, or failing to wait your turn.'),
    ('G-AHD5', 'Forgetfulness', 'Frequently forgetting or losing items needed for daily activities.')
    RETURNING symptoms_id, symptoms_code
)
INSERT INTO cf_rules (disease_id, symptoms_id, expert_cf_value)
SELECT 
    CASE 
        WHEN symptoms_code LIKE 'G-ANX%' THEN 1
        WHEN symptoms_code LIKE 'G-PTSD%' THEN 2
        WHEN symptoms_code LIKE 'G-DEP%' THEN 3
        WHEN symptoms_code LIKE 'G-OCD%' THEN 4
        WHEN symptoms_code LIKE 'G-BIP%' THEN 5
        WHEN symptoms_code LIKE 'G-SKZ%' THEN 6
        WHEN symptoms_code LIKE 'G-FOB%' THEN 7
        WHEN symptoms_code LIKE 'G-PNK%' THEN 8
        WHEN symptoms_code LIKE 'G-AHD%' THEN 9
    END,
    symptoms_id,
    -- Varied CF weights based on clinical specificity
    CASE 
        WHEN symptoms_code IN ('G-DEP1', 'G-DEP2', 'G-ANX1', 'G-PTSD1', 'G-FOB1', 'G-OCD1', 'G-OCD2', 'G-SKZ1', 'G-SKZ2', 'G-PNK1') THEN 0.95
        WHEN symptoms_code IN ('G-PTSD2', 'G-BIP1', 'G-BIP2', 'G-FOB2', 'G-SKZ3', 'G-PNK5', 'G-AHD1', 'G-AHD2') THEN 0.90
        WHEN symptoms_code IN ('G-ANX2', 'G-PTSD3', 'G-BIP3', 'G-BIP5', 'G-FOB3', 'G-OCD3', 'G-OCD5', 'G-SKZ4', 'G-PNK2', 'G-AHD3') THEN 0.85
        WHEN symptoms_code IN ('G-DEP3', 'G-ANX3', 'G-PTSD4', 'G-BIP4', 'G-FOB4', 'G-OCD4', 'G-SKZ5', 'G-PNK3', 'G-AHD4') THEN 0.80
        WHEN symptoms_code IN ('G-DEP4', 'G-ANX4', 'G-PTSD5', 'G-FOB5', 'G-PNK4', 'G-AHD5') THEN 0.75
        WHEN symptoms_code IN ('G-DEP5', 'G-ANX5') THEN 0.70
        ELSE 0.80
    END
FROM new_symptoms;

-- 5. Clear old recommendations
DELETE FROM recommendation WHERE disease_id IN (1,2,3,4,5,6,7,8,9);

-- 6. Insert new English recommendations (Generic but distinct enough, simplified for the script)
INSERT INTO recommendation (disease_id, level_id, description_recommended, activities_suggested, activities_avoidable_activities) VALUES
(1, 1, 'Mild anxiety detected. Self-care and stress management techniques are usually sufficient.', 'Practice deep breathing, maintain a regular sleep schedule, and engage in light exercise.', 'Avoid excessive caffeine and alcohol.'),
(1, 2, 'Moderate anxiety detected. Consider speaking with a counselor.', 'Try Cognitive Behavioral Therapy (CBT) workbooks, talk to friends, engage in mindfulness.', 'Avoid isolation and sleep deprivation.'),
(1, 3, 'High anxiety detected. Professional medical or psychological intervention is strongly recommended.', 'Consult a psychiatrist for evaluation, join a support group, practice strict sleep hygiene.', 'Avoid stressful triggers where possible, avoid self-medicating with alcohol.'),

(2, 1, 'Mild PTSD symptoms detected. Focus on grounding techniques.', 'Practice grounding exercises (5-4-3-2-1 technique), establish a safe routine.', 'Avoid isolating yourself from supportive family/friends.'),
(2, 2, 'Moderate PTSD symptoms detected. Therapy is highly recommended.', 'Seek Trauma-Focused CBT (TF-CBT) or EMDR therapy, maintain consistent routines.', 'Avoid using substances to numb emotions.'),
(2, 3, 'Severe PTSD symptoms detected. Immediate professional support is necessary.', 'Consult a trauma specialist, build a strong support network, consider prescribed medication.', 'Avoid engaging in high-risk behaviors.'),

(3, 1, 'Mild depression detected. Lifestyle adjustments can help.', 'Exercise for 30 minutes daily, seek sunlight exposure, socialize with loved ones.', 'Avoid staying in bed all day and social withdrawal.'),
(3, 2, 'Moderate depression detected. Professional counseling may be beneficial.', 'Engage in CBT, maintain a structured daily routine, express your feelings.', 'Avoid alcohol and making impulsive major life decisions.'),
(3, 3, 'Severe depression detected. Please seek professional psychiatric help immediately.', 'Contact a mental health professional or a crisis helpline, consider psychiatric evaluation.', 'Avoid being alone if having negative thoughts, avoid substance abuse.'),

(4, 1, 'Mild OCD tendencies detected. Awareness is the first step.', 'Practice recognizing and delaying compulsions, use mindfulness techniques.', 'Avoid giving in immediately to every compulsion.'),
(4, 2, 'Moderate OCD symptoms detected. Structured therapy can help.', 'Consider Exposure and Response Prevention (ERP) therapy, talk to a professional.', 'Avoid keeping your struggles a secret from trusted ones.'),
(4, 3, 'High OCD symptoms detected. Professional psychiatric intervention is recommended.', 'Consult a specialist for ERP therapy and potential medication, join an OCD support group.', 'Avoid reassurance-seeking behaviors.'),

(5, 1, 'Mild mood fluctuations detected. Mood tracking is advised.', 'Keep a daily mood journal, maintain a strict sleep schedule.', 'Avoid irregular sleep patterns and stimulants.'),
(5, 2, 'Moderate bipolar symptoms detected. Consultation with a psychiatrist is recommended.', 'Engage in psychotherapy, establish a consistent daily routine.', 'Avoid alcohol, recreational drugs, and extreme stress.'),
(5, 3, 'Severe bipolar symptoms detected. Urgent psychiatric evaluation is necessary.', 'Seek immediate psychiatric care, involve family in safety planning.', 'Avoid making major financial or personal decisions during episodes.'),

(6, 1, 'Mild symptoms detected. Close monitoring is advised.', 'Maintain a low-stress environment, stick to a regular schedule.', 'Avoid illicit substances, especially cannabis.'),
(6, 2, 'Moderate symptoms of schizophrenia detected. Medical consultation is strongly advised.', 'Seek psychiatric evaluation, engage in family therapy, build a support system.', 'Avoid isolating yourself and skipping meals/sleep.'),
(6, 3, 'Severe symptoms detected. Immediate medical intervention is crucial.', 'Consult a psychiatrist immediately for assessment and treatment plan.', 'Avoid discontinuing any current medications without doctor approval.'),

(7, 1, 'Mild social anxiety detected. Gradual exposure can help.', 'Take small steps to interact socially, practice positive self-talk.', 'Avoid completely avoiding social situations.'),
(7, 2, 'Moderate social anxiety detected. CBT is highly effective.', 'Engage in CBT targeting social phobia, practice public speaking in safe groups.', 'Avoid relying on alcohol to feel comfortable in social settings.'),
(7, 3, 'Severe social anxiety detected. Professional therapy is highly recommended.', 'Work with a therapist on systematic desensitization, consider support groups.', 'Avoid complete social isolation.'),

(8, 1, 'Mild panic symptoms detected. Learn panic management techniques.', 'Practice diaphragmatic breathing, learn to recognize panic triggers.', 'Avoid excessive caffeine and hyperventilation.'),
(8, 2, 'Moderate panic disorder detected. CBT is recommended.', 'Engage in CBT for panic disorder, practice relaxation techniques.', 'Avoid places you fear might trigger a panic attack (prevent agoraphobia).'),
(8, 3, 'Severe panic disorder detected. Professional psychological help is needed.', 'Consult a psychiatrist or psychologist, consider cognitive restructuring.', 'Avoid fighting the panic attack; instead, allow it to pass.'),

(9, 1, 'Mild ADHD traits detected. Organizational strategies can be very effective.', 'Use planners, break tasks into smaller steps, set alarms.', 'Avoid highly distracting environments when working.'),
(9, 2, 'Moderate ADHD symptoms detected. Behavioral coaching may help.', 'Consider behavioral therapy, optimize your workspace for focus.', 'Avoid multitasking and procrastination.'),
(9, 3, 'Severe ADHD symptoms detected. A clinical evaluation is strongly recommended.', 'Consult a psychiatrist for a formal assessment and possible treatment options.', 'Avoid self-medicating with stimulants.')
;

COMMIT;
