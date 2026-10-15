-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: gix_jafc_entity_master_ename
-- Type: INDEX

-- Name: gix_jafc_entity_master_ename; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX gix_jafc_entity_master_ename ON jafc.jafc_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
