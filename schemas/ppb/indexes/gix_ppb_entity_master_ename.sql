-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: gix_ppb_entity_master_ename
-- Type: INDEX

-- Name: gix_ppb_entity_master_ename; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX gix_ppb_entity_master_ename ON ppb.ppb_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
