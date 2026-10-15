-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_hero_rating_rwid
-- Type: INDEX

-- Name: ix_kxp_hero_rating_rwid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_hero_rating_rwid ON labkxp1.labkxp_hero_rating USING btree (rating_week_id);


--
