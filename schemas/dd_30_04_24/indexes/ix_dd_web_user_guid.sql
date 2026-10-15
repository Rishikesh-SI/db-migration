-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_web_user_guid
-- Type: INDEX

-- Name: ix_dd_web_user_guid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE UNIQUE INDEX ix_dd_web_user_guid ON dd_30_04_24.dd_web_user USING btree (user_guid);


--
