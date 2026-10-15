-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labisp.labisp_entity_master USING btree (entity_name);


--
