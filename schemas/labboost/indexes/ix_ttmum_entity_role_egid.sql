-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labboost.labboost_entity_role USING btree (entity_group_id);


--
