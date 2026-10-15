-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_rating_week_week_of_year_idx
-- Type: INDEX

-- Name: upstox_rating_week_week_of_year_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_rating_week_week_of_year_idx ON labupstox.labupstox_rating_week USING btree (week_of_year);


--
