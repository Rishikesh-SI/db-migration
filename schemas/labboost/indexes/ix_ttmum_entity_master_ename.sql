-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labboost.labboost_entity_master USING btree (entity_name);


--
