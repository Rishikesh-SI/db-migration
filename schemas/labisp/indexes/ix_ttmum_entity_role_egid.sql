-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labisp.labisp_entity_role USING btree (entity_group_id);


--
