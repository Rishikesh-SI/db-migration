-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: gix_kxp_entity_master_ename
-- Type: INDEX

-- Name: gix_kxp_entity_master_ename; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX gix_kxp_entity_master_ename ON kxp.kxp_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
