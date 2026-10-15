-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_user_activity_aid
-- Type: INDEX

-- Name: ix_yho_user_activity_aid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_user_activity_aid ON yho.yho_user_activity USING btree (user_id);


--
