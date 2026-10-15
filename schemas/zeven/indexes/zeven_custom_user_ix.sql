-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_custom_user_ix
-- Type: INDEX

-- Name: zeven_custom_user_ix; Type: INDEX; Schema: zeven; Owner: -
--

CREATE UNIQUE INDEX zeven_custom_user_ix ON zeven.zeven_custom_user USING btree (email_id);


--
