-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_author_action scom_author_action_id
-- Type: CONSTRAINT

-- Name: scom_author_action scom_author_action_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_author_action
    ADD CONSTRAINT scom_author_action_id PRIMARY KEY (author_action_id);


--
