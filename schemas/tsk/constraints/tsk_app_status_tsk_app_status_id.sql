-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_app_status tsk_app_status_id
-- Type: CONSTRAINT

-- Name: tsk_app_status tsk_app_status_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_app_status
    ADD CONSTRAINT tsk_app_status_id PRIMARY KEY (app_id);


--
