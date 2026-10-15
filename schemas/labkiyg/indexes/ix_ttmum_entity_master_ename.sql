-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labkiyg.labkiyg_entity_master USING btree (entity_name);


--
