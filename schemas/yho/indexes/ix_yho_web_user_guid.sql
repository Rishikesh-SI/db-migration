-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_web_user_guid
-- Type: INDEX

-- Name: ix_yho_web_user_guid; Type: INDEX; Schema: yho; Owner: -
--

CREATE UNIQUE INDEX ix_yho_web_user_guid ON yho.yho_web_user USING btree (user_guid);


--
