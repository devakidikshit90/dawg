/**
 * Copyright 2010 Comcast Cable Communications Management, LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.comcast.video.dawg.controller.house.filter;

import org.springframework.data.mongodb.core.query.Criteria;

import com.comcast.cereal.annotations.Cereal;

/**
 * Base class for a Condition, this provides a way to negate the condition
 * @author Kevin Pearson
 *
 */
public abstract class BaseCondition implements Condition {
    @Cereal(defaultValue="false")
    protected boolean not;

    public boolean isNot() {
        return not;
    }

    public void setNot(boolean not) {
        this.not = not;
    }

    @Override
    public Criteria toCriteria() {
        return toCriteria(false);
    }

}
