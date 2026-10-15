-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_hero_rating_rwid
-- Type: INDEX

-- Name: ix_cfc_hero_rating_rwid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_hero_rating_rwid ON cfc.cfc_hero_rating USING btree (rating_week_id);


--
