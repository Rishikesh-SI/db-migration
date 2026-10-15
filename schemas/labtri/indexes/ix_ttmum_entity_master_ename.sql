-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labtri; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labtri.labtri_entity_master USING btree (entity_name);


--
