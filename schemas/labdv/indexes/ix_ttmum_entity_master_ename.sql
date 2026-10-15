-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labdv.labdv_entity_master USING btree (entity_name);


--
