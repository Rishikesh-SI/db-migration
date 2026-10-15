-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: gix_abp_entity_master_ename
-- Type: INDEX

-- Name: gix_abp_entity_master_ename; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX gix_abp_entity_master_ename ON abpp.abp_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
