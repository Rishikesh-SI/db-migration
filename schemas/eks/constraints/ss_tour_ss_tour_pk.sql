-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_tour ss_tour_pk
-- Type: CONSTRAINT

-- Name: ss_tour ss_tour_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_tour
    ADD CONSTRAINT ss_tour_pk PRIMARY KEY (cf_tourid);


--
