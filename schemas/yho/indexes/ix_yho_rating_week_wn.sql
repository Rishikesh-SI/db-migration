-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_rating_week_wn
-- Type: INDEX

-- Name: ix_yho_rating_week_wn; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_rating_week_wn ON yho.yho_rating_week USING btree (week_number);


--
