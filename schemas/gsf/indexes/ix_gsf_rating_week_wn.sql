-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_rating_week_wn
-- Type: INDEX

-- Name: ix_gsf_rating_week_wn; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_rating_week_wn ON gsf.gsf_rating_week USING btree (week_number);


--
