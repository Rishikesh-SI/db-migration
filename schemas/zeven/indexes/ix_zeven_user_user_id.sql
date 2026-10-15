-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_user_user_id
-- Type: INDEX

-- Name: ix_zeven_user_user_id; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_user_user_id ON zeven.zeven_web_user_niu USING btree (social_id, client_id);


--
