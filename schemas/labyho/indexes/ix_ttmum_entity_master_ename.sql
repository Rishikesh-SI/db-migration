-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labyho.labyho_entity_master USING btree (entity_name);


--
