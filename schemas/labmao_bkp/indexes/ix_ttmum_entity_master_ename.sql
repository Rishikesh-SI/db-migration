-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labmao_bkp; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labmao_bkp.labmao_entity_master USING btree (entity_name);


--
