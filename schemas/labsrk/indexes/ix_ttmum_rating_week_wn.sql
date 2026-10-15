-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labsrk.labsrk_rating_week USING btree (week_number);


--
