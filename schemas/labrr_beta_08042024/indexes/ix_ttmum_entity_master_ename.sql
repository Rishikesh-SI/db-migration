-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labrr_beta_08042024; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labrr_beta_08042024.labrr_entity_master USING btree (entity_name);


--
