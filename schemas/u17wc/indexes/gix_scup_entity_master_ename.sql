-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: gix_scup_entity_master_ename
-- Type: INDEX

-- Name: gix_scup_entity_master_ename; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX gix_scup_entity_master_ename ON u17wc.u17wc_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
