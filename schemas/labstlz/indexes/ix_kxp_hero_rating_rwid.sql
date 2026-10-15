-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_hero_rating_rwid
-- Type: INDEX

-- Name: ix_kxp_hero_rating_rwid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_hero_rating_rwid ON labstlz.labstlz_hero_rating USING btree (rating_week_id);


--
