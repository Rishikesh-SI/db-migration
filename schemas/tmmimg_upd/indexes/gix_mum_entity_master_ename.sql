-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: gix_mum_entity_master_ename
-- Type: INDEX

-- Name: gix_mum_entity_master_ename; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX gix_mum_entity_master_ename ON tmmimg_upd.tmmimg_upd_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
