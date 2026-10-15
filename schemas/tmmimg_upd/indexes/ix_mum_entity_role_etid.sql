-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_entity_role_etid
-- Type: INDEX

-- Name: ix_mum_entity_role_etid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_entity_role_etid ON tmmimg_upd.tmmimg_upd_entity_role USING btree (entity_type_id);


--
