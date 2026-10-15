-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_hero_rating_wn
-- Type: INDEX

-- Name: ix_scom_hero_rating_wn; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_hero_rating_wn ON scom.scom_hero_rating USING btree (entity_role_map_id);


--
