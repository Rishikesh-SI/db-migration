-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_action scom_action_id
-- Type: CONSTRAINT

-- Name: scom_action scom_action_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_action
    ADD CONSTRAINT scom_action_id PRIMARY KEY (action_id);


--
