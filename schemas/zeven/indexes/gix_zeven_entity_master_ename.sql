-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: gix_zeven_entity_master_ename
-- Type: INDEX

-- Name: gix_zeven_entity_master_ename; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX gix_zeven_entity_master_ename ON zeven.zeven_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
