-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labukk.labukk_rating_week USING btree (week_number);


--
