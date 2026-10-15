-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_topic yho_topic_id
-- Type: CONSTRAINT

-- Name: labyho_topic yho_topic_id; Type: CONSTRAINT; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_topic
    ADD CONSTRAINT yho_topic_id PRIMARY KEY (topic_master_id);


--
