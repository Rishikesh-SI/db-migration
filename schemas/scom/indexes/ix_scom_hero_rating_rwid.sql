-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_hero_rating_rwid
-- Type: INDEX

-- Name: ix_scom_hero_rating_rwid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_hero_rating_rwid ON scom.scom_hero_rating USING btree (rating_week_id);


--
