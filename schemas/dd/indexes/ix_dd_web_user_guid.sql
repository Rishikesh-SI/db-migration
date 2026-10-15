-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_web_user_guid
-- Type: INDEX

-- Name: ix_dd_web_user_guid; Type: INDEX; Schema: dd; Owner: -
--

CREATE UNIQUE INDEX ix_dd_web_user_guid ON dd.dd_web_user USING btree (user_guid);


--
