-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labisl_v1.labisl_v1_rating_week USING btree (rating_year);


--
