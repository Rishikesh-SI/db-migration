-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_poll_option labyho_poll_option_id
-- Type: CONSTRAINT

-- Name: labyho_poll_option labyho_poll_option_id; Type: CONSTRAINT; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_poll_option
    ADD CONSTRAINT labyho_poll_option_id PRIMARY KEY (poll_option_id);


--
