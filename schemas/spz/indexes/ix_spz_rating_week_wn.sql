-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_rating_week_wn
-- Type: INDEX

-- Name: ix_spz_rating_week_wn; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_rating_week_wn ON spz.spz_rating_week USING btree (week_number);


--
