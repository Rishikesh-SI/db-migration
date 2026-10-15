-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labso_bkp.labso_entity_master USING btree (entity_name);


--
