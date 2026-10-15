-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labpcm; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labpcm.labpcm_entity_master USING btree (entity_name);


--
