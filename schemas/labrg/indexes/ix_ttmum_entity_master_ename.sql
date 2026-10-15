-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labrg; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labrg.labrg_entity_master USING btree (entity_name);


--
