-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_runner_feedback_flname
-- Type: INDEX

-- Name: ix_mum_runner_feedback_flname; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_runner_feedback_flname ON tmmimg_upd.tmmimg_upd_runner_feedback USING btree (first_name, last_name);


--
