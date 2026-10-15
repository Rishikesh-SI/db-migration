-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: gix_tcs_entity_master_ename
-- Type: INDEX

-- Name: gix_tcs_entity_master_ename; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX gix_tcs_entity_master_ename ON tcs.tcs_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
