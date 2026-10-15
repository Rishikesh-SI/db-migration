-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: gix_hsl_entity_master_ename
-- Type: INDEX

-- Name: gix_hsl_entity_master_ename; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX gix_hsl_entity_master_ename ON labhsl.labhsl_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
