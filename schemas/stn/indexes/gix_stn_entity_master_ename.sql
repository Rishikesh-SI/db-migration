-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: gix_stn_entity_master_ename
-- Type: INDEX

-- Name: gix_stn_entity_master_ename; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX gix_stn_entity_master_ename ON stn.stn_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
