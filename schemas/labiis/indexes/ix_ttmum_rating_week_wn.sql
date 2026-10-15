-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labiis; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labiis.labiis_rating_week USING btree (week_number);


--
