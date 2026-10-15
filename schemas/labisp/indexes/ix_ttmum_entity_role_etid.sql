-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_entity_role_etid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_etid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_etid ON labisp.labisp_entity_role USING btree (entity_type_id);


--
