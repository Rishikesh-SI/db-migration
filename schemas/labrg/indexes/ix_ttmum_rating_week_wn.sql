-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labrg; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labrg.labrg_rating_week USING btree (week_number);


--
